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
      *===============================================================*
      /COPY QCOPYLE,H_SPEC
      /COPY QCOPYLE,COPYRIGHT
      *
      *---Variablendefinition------------------------------*
      /COPY QCOPYLE,D_VARDEF
      *----------------------------------------------------*
      *
      *---Nachrichten--------------------------------------*
 CPY  ***/COPY QCOPYLE,MSG_D_MAPI
      *----------------------------------------------------*
      *
      *---SDS-Datenstruktur--------------------------------*
      /COPY QCOPYLE,ERR_D_SDS
      *----------------------------------------------------*
      *
      *----------------------------------------------------*
      *  F E L D - D E F I N I T I O N E N                 *
      *----------------------------------------------------*
      *
     D XMode           S             10A
     D XSection        S             10A
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
      ********************************************************************
      *                 S T E U E R  -  R O U T I N E                    *
      ********************************************************************
      *
     C     *ENTRY        PLIST
     C                   PARM                    XMode
     C                   PARM                    XSection
      *
      *---------------------------------------------------*
      *
      *  Kopieren für alle Programme ...
     C     XSection      IFEQ      '*ALL'
      *
     C                   MOVEL (P) '*PEEK05'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK12'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK14'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK17'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK24'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK25'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK26'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK30'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK34'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK37'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK40'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK45'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK47'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK48'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK49'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK50'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK52'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK56'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK57'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK59'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK64'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK68'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PEEK69'     Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PXXXXXXXX'  Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*CMD'        Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   MOVEL (P) '*PGM'        Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   ELSE
      *
      *  Kopieren für ein Programm
     C                   MOVEL (P) XSection      Wrk_Sectn
     C                   EXSR      DelRecords
     C                   EXSR      AddRecords
      *
     C                   Endif
      *
     C     ENDE          TAG
      *
     C                   MOVEL (P) '1'           *INLR
      *
      *============================================================*
      *    DelRecords    Löschen von Datensätzen                   *
      *============================================================*
      *
     C     DelRecords    BEGSR
      *
     C     XMode         IFEQ      '*REPLACE'
     C     XMode         OREQ      '*DELETE'
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
     C     XMode         IFEQ      '*ADD'
     C     XMode         OREQ      '*REPLACE'
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
      *    *INZSR        Programminitialisierung                   *
      *============================================================*
      *
     C     *INZSR        BEGSR
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
