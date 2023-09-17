      /IF NOT DEFINED(D_MI)                                                                   RADDAT
      /DEFINE D_MI                                                                            RADDAT
?     *                                                                                       RADDAT
     D NUM_Descr_T     S             10I 0 based(pDummy)                                      RADDAT
?     *                                                                                       RADDAT
?     *  Copy Numeric Value (CPYNV)                                                           RADDAT
     D cpynv...                                                                               RADDAT
     D                 PR              *          extproc('cpynv')                            RADDAT
     D  i_rcvDesc                          value  like(NUM_Descr_T )                          RADDAT
     D  i_pRcvVar                      *   value                                              RADDAT
     D  i_srcDesc                          value  like(NUM_Descr_T )                          RADDAT
     D  i_pSrcVar                      *   value                                              RADDAT
?     *                                                                                       RADDAT
?     *  These values must be specified on the Scalar Type for CPYNV,                         RADDAT
?     *  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM     RADDAT
     D T_SIGNED        C                   const(x'00')                                       RADDAT
     D T_FLOAT         C                   const(x'01')                                       RADDAT
     D T_ZONED         C                   const(x'02')                                       RADDAT
     D T_PACKED        C                   const(x'03')                                       RADDAT
     D T_CHAR          C                   const(x'04')                                       RADDAT
     D T_ONLYNS        C                   const(x'06')                                       RADDAT
     D T_ONLYN         C                   const(x'07')                                       RADDAT
     D T_EITHER        C                   const(x'08')                                       RADDAT
     D T_OPEN          C                   const(x'09')                                       RADDAT
     D T_UNSIGNED      C                   const(x'0A')                                       RADDAT
?     *                                                                                       RADDAT
      /ENDIF                                                                                  RADDAT
