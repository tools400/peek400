      /IF NOT DEFINED(D_MI)
      /DEFINE D_MI
      *
     D NUM_Descr_T     S             10I 0 based(pDummy)
      *
      *  Copy Numeric Value (CPYNV)
     D cpynv...
     D                 PR              *          extproc('cpynv')
     D  i_rcvDesc                          value  like(NUM_Descr_T )
     D  i_pRcvVar                      *   value
     D  i_srcDesc                          value  like(NUM_Descr_T )
     D  i_pSrcVar                      *   value
      *
      *  These values must be specified on the Scalar Type for CPYNV,
      *  CVTEFN, and EDIT instructions.                              QSYSINC/MIH.MICPTCOM
     D T_SIGNED        C                   const(x'00')
     D T_FLOAT         C                   const(x'01')
     D T_ZONED         C                   const(x'02')
     D T_PACKED        C                   const(x'03')
     D T_CHAR          C                   const(x'04')
     D T_ONLYNS        C                   const(x'06')
     D T_ONLYN         C                   const(x'07')
     D T_EITHER        C                   const(x'08')
     D T_OPEN          C                   const(x'09')
     D T_UNSIGNED      C                   const(x'0A')
      *
      /ENDIF
