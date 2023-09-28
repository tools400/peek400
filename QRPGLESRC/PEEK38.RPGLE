      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 3.2.6                               *
      *  Programm : PEEK38                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 05.04.2011  Thomas Raddatz                        *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Peek/400 - Erstellen SQL ORDER BY                            *
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
      /COPY QCOPYLE,FLDL0100
      *----------------------------------------------------*
      *
      /define internal_prototype
      /COPY QCOPYLE,PPEEK38
      /undefine internal_prototype
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *---API-Formate--------------------------------------*
     D KEYL0100        DS                  likeds(KEYL0100_t) inz
      /COPY QCOPYLE,KEYL0100
      *----------------------------------------------------*
      *
      *  Peek41:
     D YQFile          DS                  likeds(qObj_t)
     D YData           S            512A   INZ(*BLANKS)
      *
     D PEEK41_NAME     S                   like(pgmCallN_t) inz
      *
     D rc              S                   like(int4_t) inz
     D NbrOfKey        S                   like(int4_t) inz
     D tempField       S                   Like(o_sqlOrder ) inz
      *
      /COPY QCOPYLE,PPEEK41
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
     D PEEK38          PI
     D  i_file                             const like(file_t)
     D  i_lib                              const like(lib_t)
     D  o_sqlOrder                               like(sqlOrder_t)
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
     C                   EXSR      InzSr
      *
      *  Einlesen der Dateiinformationen ...
     C                   EVAL      YQFile.name = i_file
     C                   EVAL      YQFile.lib = i_lib
     C                   CALLP     PEEK41(YQFile: '*FIRST': '*CREATE'
     C                                    : rc: YData)
      *
      *  Einlesen der Schlüsselinformationen ...
     C                   CALLP     PEEK41(YQFile: '*FIRST': '*KEY'
     C                                    : NbrOfKey: yData)
      *
     C                   Eval      tempField = ' '
      *
     C     1             Do        NbrOfKey
     C                   CALLP     PEEK41(YQFile: '*FIRST': '*READKEY'
     C                                    : rc: yData)
     C                   EVAL      KEYL0100 = yData
      *
     C                   If        tempField = *BLANKS
     C                   Eval      tempField =
     C                               %trim(tempField) +
     C                               '"' + %trim(KEYL0100.APKEYF) + '"'
     C                   Else
     C                   Eval      tempField =
     C                               %trim(tempField) +
     C                               ', "' + %trim(KEYL0100.APKEYF) + '"'
     C                   Endif
      *
     C                   Select
     C                   When      KEYL0100.APKSEQ = 'A'
     C                   Eval      tempField = %trim(tempField) + ' ASC'
     C                   When      KEYL0100.APKSEQ = 'D'
     C                   Eval      tempField = %trim(tempField) + ' DESC'
     C                   Other
      *          keine Schlüsselangaben gefunden
     C                   Endsl
      *
     C                   Enddo
      *
     C                   Eval      o_sqlOrder = tempField
      *
     C                   Return
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
     C                   Eval      PEEK41_NAME = f_pgmCallN('PEEK41')
      *
     C                   Endsr
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
