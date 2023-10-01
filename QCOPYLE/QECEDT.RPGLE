      /if not defined(QECEDT)
      /define QECEDT
      *
      *  Edit (QECEDT) API
     d QECEDT...
     d                 pr                         extpgm('QECEDT')
     D  o_rcvVar                  65535A         options(*varsize)
     D  i_lenRcvVar                  10I 0 const
     D  i_srcVar                  65535A   const options(*varsize)
     D  i_srcVarClass                10A   const
     D  i_srvVarPrecision...
     D                               10I 0 const
     D  i_editMask                65535A   const options(*varsize)
     D  i_editMaskLen                10I 0 const
     D  i_zeroBalFillChar...
     D                                1A   const
     D  io_errCode                65535A          options(*nopass: *varsize)
      *
      /endif
