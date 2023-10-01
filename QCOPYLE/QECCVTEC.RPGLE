      /if not defined(QECCVTEC)
      /define QECCVTEC
      *
      *  Convert Edit Code (QECCVTEC) API
     d QECCVTEC...
     d                 pr                         extpgm('QECCVTEC')
     D  o_editMask                65535A         options(*varsize)
     D  o_editMaskLen                10I 0
     D  o_rcvVarLen                  10I 0
     D  o_zeroBalFillChar...
     D                                1A   const
     D  i_editCode                    1A   const
     D  i_fillOrFloatCurrencyInd...
     D                                1A   const
     D  i_srvVarPrecision...
     D                               10I 0 const
     D  i_srvVarDecPos...
     D                               10I 0 const
     D  io_errCode                65535A          options(*nopass: *varsize)
      *
      /endif
