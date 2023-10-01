      /if not defined(QECCVTEW)
      /define QECCVTEW
      *
      *  Convert Edit Word (QECCVTEW) API
     d QECCVTEW...
     d                 pr                         extpgm('QECCVTEW')
     D  o_editMask                65535A         options(*varsize)
     D  o_editMaskLen                10I 0
     D  o_rcvVarLen                  10I 0
     D  i_editWord                65535A   const options(*varsize)
     D  i_editWordLen                10I 0 const
     D  io_errCode                65535A          options(*nopass: *varsize)
     D  i_srcLen                     10I 0 const  options(*nopass)              | optGrp 1
     D  i_currencySymbol...                                                     |
     D                                1A   const  options(*nopass)              |
      *
      /endif
