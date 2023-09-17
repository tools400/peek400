      *
      *  Templates  (micptcom.h)
     D int             S             10I 0                   based(pDummy)
     D NUM_Descr_T     S                   like(int       )  based(pDummy)
      *
      *  Constants  (micptcom.h)
     D T_Signed        C                   const(x'00')
     D T_Float         C                   const(x'01')
     D T_Zoned         C                   const(x'02')
     D T_Packed        C                   const(x'03')
     D T_Char          C                   const(x'04')
     D T_OnlyNS        C                   const(x'06')
     D T_OnlyN         C                   const(x'07')
     D T_Either        C                   const(x'08')
     D T_Open          C                   const(x'09')
     D T_Unsigned      C                   const(x'0A')
      *
      *  Copy Numeric Value
     D cpynv...
     D                 PR              *   extproc('cpynv')
     D  o_rcvr_descr                       value  like(NUM_Descr_T)
     D  o_receiver                     *   value
     D  i_src_descr                        value  like(NUM_Descr_T)
     D  i_source                       *   value
      *
