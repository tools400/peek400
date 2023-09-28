      *===============================================================*
      *                                                               *
      *  (c) Thomas Raddatz                                           *
      *                                                               *
      *  Bereich  : PEEK, Version 2.1.0                               *
      *  Programm : PEEK22                                            *
      *  Typ      : RPG                                               *
      *                                                               *
      *  erstellt : 29.10.97  Raddatz                                 *
      *  geändert : 27.04.99  2.1.0                                   *
      *                                                               *
      *===============================================================*
      *                                                               *
      *  Kurzdokumentation :                                          *
      *                                                               *
      *  Generieren der Defaulttastenbelegung                         *
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
      /COPY QCOPYLE,PPEEK22
      /undefine internal_prototype
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D Wrk_Sectn       S                   LIKE(R§SECTION )
     D                                     INZ
     D Wrk_Key         S                   LIKE(R§KEY     )
     D                                     INZ
     D Wrk_Data        S                   LIKE(R§SET0000 )
     D                                     INZ
      *
      /COPY QCOPYLE,F_PEEK53
      *
      /COPY QCOPYLE,CEECNDHDLR
      *
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     D PEEK22          PI
     D  i_mode                       10A   const
     D  i_section                    10A   const
      *
      *---------------------------------------------------*
      *
      *  Register error handler
     C                   callp     CEEHDLR(%paddr('errorHandler')
     C                                     : *null: *omit)
      *
      *  Kopieren für alle Programme ...
     C     i_section     IFEQ      '*ALL'
      *
     C                   EVAL      Wrk_Sectn = '*PEEK05'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK12'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK14'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK17'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK24'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK25'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK26'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK30'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK34'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK37'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK40'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK45'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK47'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK48'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK49'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK50'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK52'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK56'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK57'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK59'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK64'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK68'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PEEK69'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PXXXXXXXX'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*CMD'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   EVAL      Wrk_Sectn = '*PGM'
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   ELSE
      *
      *  Kopieren für ein Programm
     C                   EVAL      Wrk_Sectn = i_section
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   Endif
      *
     C     ENDE          TAG
      *
     C                   EVAL      *INLR = '1'
      *
      *============================================================*
      *    DelRecords    Löschen von Datensätzen                   *
      *============================================================*
      *
     C     DelRecords    BEGSR
      *
     C     i_mode        IFEQ      '*REPLACE'
     C     i_mode        OREQ      '*DELETE'
      *
     C                   Callp     p_setllUsr(Wrk_Sectn: '*F01')
      *
     C                   DOW       f_readeUsr(Wrk_Sectn: Wrk_Key)= '0'
     C                   Callp     f_deletUsr(Wrk_Sectn: Wrk_Key)
     C                   Enddo
      *
     C                   ELSE
      *    Löschen bestehender Datensäötze nur bei
      *    Betriebsart *REPLACE oder *DELETE.
      *    Sonst nicht!
     C                   Endif
      *
     C                   ENDSR
      *
      *============================================================*
      *    AddRecords    Hinzufügen von Datensätzen                *
      *============================================================*
      *
     C     Addrecords    BEGSR
      *
     C     i_mode        IFEQ      '*ADD'
     C     i_mode        OREQ      '*REPLACE'
      *
     C                   Callp     p_setllDft(Wrk_Sectn)
      *
     C                   DOW       f_readeDft(Wrk_Sectn: Wrk_Key: Wrk_Data)='0'
     C                   Callp     f_writeUsr(Wrk_Sectn :
     C                                        Wrk_Key   :
     C                                        Wrk_Data  )
     C                   Enddo
      *
     C                   ELSE
      *    Hinzufügen von Datensätzen nur in der
      *    Betriebsart *ADD oder *REPLACE.
      *    Sonst nicht!
     C                   Endif
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
